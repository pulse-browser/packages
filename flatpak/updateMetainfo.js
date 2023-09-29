const { create } = require('xmlbuilder2')
const { readFile, writeFile } = require('node:fs/promises')
const md = require('markdown-it')()

const CHANGELOG_URL =
  'https://raw.githubusercontent.com/pulse-browser/browser/alpha/CHANGELOG.md'
const METAINFO_PATH = 'alpha/com.fushra.browser.metainfo.xml'
const TEMPLATE_PATH = 'alpha/com.fushra.browser.metainfo.template.xml'

;(async () => {
  const changelog = await (await fetch(CHANGELOG_URL)).text()

  const changelogAST = md.parse(changelog)
  /** @type {Record<string, Token[]>} */
  const versionTokens = {}

  let started = false
  let currentVersion = ''

  for (const token of changelogAST) {
    if (token.type === 'heading_open' && token.tag === 'h2') {
      started = true
      currentVersion = ''
      continue
    }

    if (!started || (token.type == 'heading_close' && token.tag === 'h2'))
      continue

    if (currentVersion == '' && token.type === 'inline') {
      currentVersion = token.content
      versionTokens[currentVersion] = []
      continue
    }

    versionTokens[currentVersion].push(token)
  }

  const releaseXML = create().ele('releases')

  for (const version in versionTokens) {
    releaseXML
      .ele('release', {
        version,
      })
      .ele('description')
      .ele(md.renderer.render(versionTokens[version]))
      .up()
      .up()
  }

  const template = await readFile(TEMPLATE_PATH, 'utf-8')
  const out = releaseXML.end({ prettyPrint: true, headless: true, offset: 2 })
  await writeFile(METAINFO_PATH, template.replace('#releases', out))
})()
