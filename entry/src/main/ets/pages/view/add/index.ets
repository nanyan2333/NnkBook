import { bookItem } from '../../../utils/dataInterface'
import { appendFile } from '../../../utils/file'
import { getNowDate, getNowTime } from '../../../utils/time'
import { JSON } from '@kit.ArkTS'

@Component
export struct addIndex {
  @State form: bookItem = {
    timeMap: getNowTime(),
    type: '',
    sum: '',
    description: ''
  }
  @Consume todayData: bookItem[]
  private fileName: string = getNowDate() + $r('app.string.file_specification')

  aboutToAppear(): void {
    // console.info("add comp has appear")
  }

  build() {
    Column({ space: 16 }) {
      Row({ space: 10 }) {
        Text('类型')
        TextInput({ placeholder: '类型', text: this.form.type }).onChange((val: string) => {
          this.form.type = val
        })
      }

      Row({ space: 10 }) {
        Text('数目')
        TextInput({ placeholder: '数目', text: this.form.sum }).onChange((val: string) => {
          this.form.sum = val
        })
      }

      Row({ space: 10 }) {
        Text('描述')
        TextInput({ placeholder: '描述', text: this.form.description }).onChange((val: string) => {
          this.form.description = val
        })
      }

      Flex({ direction: FlexDirection.RowReverse }) {
        Button("提交").height(40).width('30%').padding(10).onClick(() => {
          const newForm: bookItem = {
            timeMap: getNowTime(),
            type: this.form.type,
            sum: this.form.sum,
            description: this.form.description
          };
          this.todayData.push(newForm)
          appendFile(getNowDate(), newForm)
        })
      }
    }
  }
}