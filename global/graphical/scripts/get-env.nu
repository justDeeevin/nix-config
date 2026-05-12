export def getenv [--name(-n): string, --pid(-p): int]: nothing -> record {
    if $name == null and $pid != null {
        getenv-inner $pid
    } else if $name != null and $pid == null {
        let procs = ps | where name == $name
        if ($procs | length) == 0 {
            error make "No process found with given name"
        } else if ($procs | length) > 1 {
            error make "Multiple processes found with given name"
        }
        getenv-inner $procs.0.pid
    } else {
        error make {
            msg: "Cannot provide both name and pid"
            labels: [
                {
                    text: "name"
                    span: (metadata $name).span
                }
                {
                    text: "pid"
                    span: (metadata $pid).span
                }
            ]
        }
    }
}
def getenv-inner [pid: int]: nothing -> record {
    open --raw $"/proc/($pid)/environ" | split row (char nul) | where $it != "" | each {|s|
            let parts = ($s | split row "=")
            {key: $parts.0, value: ($parts | skip 1 | str join "=")}
        } | transpose -ird
}
