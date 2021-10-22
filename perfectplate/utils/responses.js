module.exports = {
  success(data) {
    var res = new Object()
    res.ok = true
    res.data = data
    return res
  },
  fail(message) {
    var res = new Object()
    res.ok = false
    res.message = message
    return res
  }
}
