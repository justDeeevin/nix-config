export def "to nix" [--formatter (-f): path]: any -> string {
  if $formatter != null {
    to_nix_inner | ^$formatter
  } else {
    to_nix_inner
  }
}

def to_nix_inner []: any -> string {
  let value = $in

  match ($value | describe -d).type {
    "bool" => {
      if $value {"true"} else {"false"}
    }
    "binary" => {
      $value | format bits | parse -r `(\d{8})*` | get capture0 | each {into int} | to_nix_inner
    }
    "cell-path" => {
      error make {msg: "Cannot convert cell path to Nix"}
    }
    "closure" => {
      error make {msg: "Cannot convert closure to Nix"}
    }
    "datetime" => {
      $value | format date "%+" | to_nix_inner
    }
    "duration" => {
      (if $value < 1us {
        $value | format duration ns
      } else if $value < 1ms {
        $value | format duration us
      } else if $value < 1sec {
        $value | format duration ms
      } else if $value < 1min {
        $value | format duration sec
      } else if $value < 1hr {
        $value | format duration min
      } else if $value < 1day {
        $value | format duration hr
      } else if $value < 1wk {
        $value | format duration day
      } else {
        $value | format duration wk
      }) | to_nix_inner
    }
    "filesize" => {
      (if $value < 1kb {
        $value | format filesize B
      } else if $value < 1mb {
        $value | format filesize KB
      } else if $value < 1gb {
        $value | format filesize MB
      } else if $value < 1tb {
        $value | format filesize GB
      } else if $value < 1pb {
        $value | format filesize TB
      } else if $value < 1eb {
        $value | format filesize PB
      } else {
        $value | format filesize EB
      }) | to_nix_inner
    }
    "float" => {
      $value | into string
    }
    "glob" => {
      error make {msg: "Cannot convert glob to Nix"}
    }
    "int" => {
      $value | into string
    }
    "list" => {
      $"[($value | each {to_nix_inner} | str join ' ')]"
    }
    "nothing" => "null"
    "range" => {
      let start = take 1
      if $value == $start.. {
        error make {msg: "Cannot convert infinite range to Nix"}
      } else {
        $value | each {||} | to_nix_inner
      }
    }
    "record" => {
      $'{($value | items {|name, value| $"($name) = ($value | to_nix_inner);"} | str join " ")}'
    }
    "string" => {
      $'"($value)"'
    }
    "table" => {
      $value | each {to_nix_inner} | to_nix_inner
    }
  }
}
