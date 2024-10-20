import { bookItem } from "../../../utils/dataInterface"
import { readFile } from "../../../utils/file"

import { getNowDate, getNowTime } from "../../../utils/time"

@Component
export struct settingIndex {
  @State test: bookItem[] = []
  private fileName: string = 'test'
  @State message: string = ''

  get(): bookItem {
    const form: bookItem = {
      timeMap: getNowTime(),
      type: '',
      sum: '',
      description: ''
    }
    return form
  }

  build() {
    Button('点击').onClick(()=>{
      readFile(getNowDate()).then((res)=>{
        console.info(JSON.stringify(res))
      })
    })

  }
}