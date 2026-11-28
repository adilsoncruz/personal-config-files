import { assert, mount, test } from 'orca/testing'
import * as panel from './panel'

test('mounts smart router panel without errors', async () => {
  const view = await mount(panel)
  assert.ok(view.find({ text: '⚡ Smart Model Matrix' }))
  assert.equal(view.errors.length, 0)
  await view.unmount()
})
