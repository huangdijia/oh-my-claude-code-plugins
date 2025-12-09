module.exports = {
  branches: [
    'main',
    {
      name: 'develop',
      prerelease: 'dev'
    },
    {
      name: 'feature/*',
      prerelease: 'alpha'
    },
    {
      name: 'hotfix/*',
      prerelease: 'beta'
    }
  ],
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    '@semantic-release/changelog',
    '@semantic-release/npm',
    '@semantic-release/github',
    [
      '@semantic-release/git',
      {
        assets: ['CHANGELOG.md', 'package.json'],
        message: 'chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}'
      }
    ]
  ]
};