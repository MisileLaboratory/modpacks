node {
  agent {
    docker { image 'crazymax/7zip:edge' }
  }
  stage('clone') {
    git 'https://github.com/MisileLab/modpacks'
  }
  stage('zip') {
    dir('modpacks') {
      sh '7za a -t7z basiccraft.7z BasicCraft/mods/*'
      sh '7za a -t7z somemechaincs.7z SomeMechanics/mods/*'
      archiveArtifacts 'basiccraft.7z'
      archiveArtifacts 'somemechaincs.7z'
    }
  }
}
