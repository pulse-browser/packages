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
  const releaseStr = await downloadToString(
    'https://api.github.com/repos/dothq/browser-desktop/releases/latest'
  )
  const releases = JSON.parse(releaseStr)

  for (let i = 0; i < releases.assets.length; i++) {
    const asset = releases.assets[i]
    if (asset.name.includes('tar.bz2')) {
      console.log(asset.browser_download_url)
      execSync(`curl ${asset.browser_download_url} -o dot.tar.bz2`)
    }
  }
})()
