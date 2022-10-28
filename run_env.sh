#!/bin/sh

echo Namespace?
read namespace

echo Pod?
read pod

export DYLD_INSERT_LIBRARIES=$PWD/libmirrord_layer.dylib
export LD_PRELOAD=$PWD/libmirrord_layer.so
export MIRRORD_AGENT_RUST_LOG=INFO
export RUST_LOG=INFO
export MIRRORD_ACCEPT_INVALID_CERTIFICATES=true
export MIRRORD_EPHEMERAL_CONTAINER=false
export MIRRORD_SKIP_PROCESSES=
export MIRRORD_OVERRIDE_ENV_VARS_INCLUDE=*
export MIRRORD_IMPERSONATED_TARGET=pod/$pod
export MIRRORD_TARGET_NAMESPACE=$namespace
export MIRRORD_FILE_OPS=false
export MIRRORD_AGENT_TCP_STEAL_TRAFFIC=true
export MIRRORD_REMOTE_DNS=true
export MIRRORD_TCP_OUTGOING=true
export MIRRORD_UDP_OUTGOING=false

# IntelliJ Run - works!
#$JAVA_HOME/bin/java \
# -javaagent:"/Applications/IntelliJ IDEA.app/Contents/lib/idea_rt.jar=50527:/Applications/IntelliJ IDEA.app/Contents/bin" \
# -Dfile.encoding=UTF-8 \
# -classpath $PWD/target/classes \
# SimpleServer

# IntelliJ Debug - not working...
$JAVA_HOME/bin/java \
 -agentlib:jdwp=transport=dt_socket,address=127.0.0.1:50547,suspend=y,server=n \
 -javaagent:"/Users/jamowei/Library/Caches/JetBrains/IntelliJIdea2022.2/captureAgent/debugger-agent.jar" \
 -Dfile.encoding=UTF-8 \
 -classpath $PWD/target/classes:"/Applications/IntelliJ IDEA.app/Contents/lib/idea_rt.jar" \
 SimpleServer