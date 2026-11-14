{ pkgs, lib, ... }:
let
  publicPort = 8012;
  backendPort = 8013;
  serviceName = "llama-fim";
  proxyName = "${serviceName}-proxy";
in
{
  systemd.user.sockets.${proxyName} = {
    wantedBy = [ "sockets.target" ];
    listenStreams = [ "127.0.0.1:${toString publicPort}" ];
  };

  systemd.user.services.${proxyName} = {
    requires = [ "${serviceName}.service" ];
    after = [ "${serviceName}.service" ];
    serviceConfig.ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd --exit-idle-time=10min 127.0.0.1:${toString backendPort}";
  };

  systemd.user.services.${serviceName} = {
    unitConfig.StopWhenUnneeded = true;
    serviceConfig = {
      ExecStart = builtins.concatStringsSep " " [
        "${pkgs.llama-cpp}/bin/llama-server"
        "--host 127.0.0.1 --port ${toString backendPort}"
        "-hf ggml-org/Qwen2.5-Coder-7B-Q8_0-GGUF"
        "-ngl all -np 1 -c ${toString (16 * 1024)} --cache-reuse 256 -b 1024 -ub 1024"
      ];
      ExecStartPost = "${lib.getExe pkgs.curl} -fsS --retry 60 --retry-delay 1 --retry-all-errors --retry-connrefused http://127.0.0.1:${toString backendPort}/health";
      TimeoutStartSec = 120;
    };
  };
}
