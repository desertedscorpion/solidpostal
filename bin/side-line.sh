#!/bin/bash

NAME=${1} &&
    URL=${2} &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    (cat > <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@2.4.4">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <name>origin</name>
        <url>${URL}</url>
        <credentialsId>79ad7607-ef6e-4e5f-a139-e633aded192b</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/scratch*</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions>
      <hudson.plugins.git.extensions.impl.CleanBeforeCheckout/>
      <hudson.plugins.git.extensions.impl.PreBuildMerge>
        <options>
          <mergeRemote>origin</mergeRemote>
          <mergeTarget>master</mergeTarget>
          <mergeStrategy>default</mergeStrategy>
          <fastForwardMode>FF</fastForwardMode>
        </options>
      </hudson.plugins.git.extensions.impl.PreBuildMerge>
    </extensions>
  </scm>
  <assignedNode>dockerhost</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>./testing.sh</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.plugins.git.GitPublisher plugin="git@2.4.4">
      <configVersion>2</configVersion>
      <pushMerge>true</pushMerge>
      <pushOnlyIfSuccess>true</pushOnlyIfSuccess>
      <forcePush>false</forcePush>
      <branchesToPush>
        <hudson.plugins.git.GitPublisher_-BranchToPush>
          <targetRepoName>origin</targetRepoName>
          <branchName>master</branchName>
        </hudson.plugins.git.GitPublisher_-BranchToPush>
      </branchesToPush>
    </hudson.plugins.git.GitPublisher>
  </publishers>
  <buildWrappers/>
</project>
EOF
) | java hudson.cli.CLI -s http://127.0.0.1:8080 create-job "${NAME}" &&
    true
