require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import '../src/application.scss'
// 今後マニフェイスとファイルを分けても良いかもね。
import '../src/teachers/schedules'
import '../src/students/lessons'
