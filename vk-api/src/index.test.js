/* eslint-env mocha */

import cleanIndex from 'inject-loader!./index' // eslint-disable-line import/no-webpack-loader-syntax

describe('index', () => {
  it('should apply shortcuts to vk', () => {
    let baseMethod
    let base

    const vk = cleanIndex({
      './shortcuts' (b, bm) {
        base = b
        baseMethod = bm
      }
    }).default

    base.should.equal(vk)
    baseMethod.should.equal('method')
  })
})
