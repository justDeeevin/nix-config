export def flake-update [
    --exclude(-x): any # Input(s) to exclude from update (string | list<string>)
]: nothing -> nothing {
    let excludes = match ($exclude | describe) {
        string => [$exclude]
        "list<string>" => $exclude
        nothing => []
        _ => (error make {
            msg: $"Invalid type for --exclude", 
            labels: [
                {
                    text: $"found ($exclude | describe)", 
                    span: (metadata $exclude).span
                }
            ]
            help: "Expected a string or list of strings"
        })
    }

    jj st | ignore

    let inputs = nix flake update e>| find -n Updated | parse -r `^• Updated input '(?<input>[^/]*)':$` | get input | where $it not-in $excludes

    jj undo e>| ignore

    nix flake update ...$inputs
}
