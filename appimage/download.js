// This file was copied from shared/scripts. Edit it there instead
const { get } = require('https')
const { createWriteStream } = require('fs')
const { execSync } = require('child_process')

function download(url, dest) {
  return new Promise((resolve, reject) => {
    let file = createWriteStream(dest)

    get(url, (res) => {
      res.pipe(file)
      file.on('finish', () => file.close(resolve))
    })
  })
}

function downloadToString(url) {
  return new Promise((resolve, reject) => {
    let consensus

    get(
      url,
      {
        headers: {
          'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0',
        },
      },
      (res) => {
        res.on('data', (chunk) => {
          if (chunk.toString() != 'undefined') consensus += chunk.toString()
        })
        res.on('end', () => resolve(consensus.replace('undefined', '')))
        res.on('error', reject)
      }
    )
  })
}

;(async () => {
  const workflowRuns = JSON.parse(
    await downloadToString(
      'https://api.github.com/repos/dothq/browser-desktop/actions/workflows/build.yml/runs'
    )
  )

  const artifactList = JSON.parse(
    await downloadToString(`${workflowRuns.workflow_runs[0].url}/artifacts`)
  )

  for (let i = 0; i < artifactList.artifacts.length; i++) {
    const asset = artifactList.artifacts[i]
    if (asset.name.includes('tar.bz2')) {
      console.log(asset.browser_download_url)
      execSync(`curl -L ${asset.browser_download_url} -o dot.tar.bz2`)
    }
  }
})()