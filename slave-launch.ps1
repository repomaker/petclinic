[CmdletBinding(DefaultParametersetName = "WithoutTunnel")]
param (
    [Parameter(Mandatory = $true, Position = 1)]
    [String]
    $Url,

    [Parameter(ParameterSetName = "WithTunnel", Mandatory = $true, Position = 2)]
    [String]
    $Tunnel,

    [Parameter(ParameterSetName = "WithTunnel", Position = 3)]
    [String]
    $Secret1,

    [Parameter(ParameterSetName = "WithTunnel", Position = 4)]
    [String]
    $AgentName1,

    [Parameter(ParameterSetName = "WithoutTunnel", Position = 2)]
    [String]
    $Secret2,

    [Parameter(ParameterSetName = "WithoutTunnel", Position = 3)]
    [String]
    $AgentName2
)

$secret = @{$true = $Secret1; $false = $Secret2}[$Secret1 -ne ""]
$agentName = @{$true = $AgentName1; $false = $AgentName2}[$AgentName1 -ne ""]

if ($env:JENKINS_TUNNEL) {
    $Tunnel = $env:JENKINS_TUNNEL
}

if ($env:JENKINS_URL) {
    $Url = $env:JENKINS_URL
}

if ($env:JENKINS_SECRET -and $secret) {
    Write-Warning "Secret is defined twice, in command-line argument and environment variable"
}
elseif ($env:JENKINS_URL) {
    $secret = $env:JENKINS_URL
}

if ($env:JENKINS_AGENT_NAME -and $agentName) {
    Write-Warning "Agent Name is defined twice, in command-line argument and environment variable"
}
elseif ($env:JENKINS_AGENT_NAME) {
    $agentName = $env:JENKINS_AGENT_NAME
}


$params = @("-headless")

if ($Tunnel) {
    $params += @("-tunnel", $Tunnel)
}

$params += ( `
    "-url", $Url, `
    "-workDir", "C:/Jenkins/Agents", `
    $secret, `
    $agentName `
)

function Show-Commandline {
    $args
}

Show-Commandline "java $javaOpts $jnlpProtocolOpts -cp ./slave.jar hudson.remoting.jnlp.Main" @params

# run slave
. java $javaOpts $jnlpProtocolOpts -cp ./slave.jar hudson.remoting.jnlp.Main @params