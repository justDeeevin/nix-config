# Finds the destination of a sequence of symlinks given a command or path
export def drill [
    link: string # The command name or path to follow
    --long(-l) # Get all available columns for listed files
    --which(-w) # Interpret `link` as a command name and use `which` to find the path
    --trace(-t) # List each symlink encountered
]: nothing -> table {
    mut path = if $which {
        let which = which $link
        if $which.type.0 == "built-in" {
            error make {
                msg: "Built-in command provided"
                labels: [
                    {
                        text: "command name"
                        span: (metadata $link).span
                    }
                ]
                help: $"If you wanted to use an external command of the same name, use the caret \(`^`) prefix instead: `drill -w ^($link)`"
            }
        }
        $which.path.0
    } else { $link }
    mut paths = [$path]
    while (ls $path | get type.0) == "symlink" {
        $path = (ls -l $path | get target.0)
        if $trace { $paths = ($paths | append $path) }
    }
    if not $trace { $paths = [$path] }
    if $long { ls -l ...$paths } else { ls ...$paths }
}
