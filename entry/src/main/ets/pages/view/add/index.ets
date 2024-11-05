import { bookItem } from '../../../utils/dataInterface'
import { appendFile } from '../../../utils/file'
import { getNowDate, getNowTime } from '../../../utils/time'
import { tagMenu } from './tagMenu'
import { showDialog } from '../../../utils/confirmDialog'
import { promptAction } from '@kit.ArkUI'

@Extend(Text)
function titleStyle() {
  .fontSize(17).fontWeight(400)
}

@Component
export struct addIndex {
  @Provide form: bookItem = {
    timeMap: getNowTime(),
    type: '',
    tag: -1,
    sum: '',
    description: ''
  }
  @Provide buttonText: string = '请选择标签'
  @Consume todayData: bookItem[]
  numRegExp: RegExp = /^\d+(\.\d{1,2})?$/
  onSubmit = () => {
    if (this.form.type === '' || !this.form.type) {
      showDialog('表单验证错误', '请选择类型', () => {
      })
    } else if (!this.numRegExp.test(this.form.sum)) {
      console.log(this.form.sum.length.toString())
      showDialog('表单验证错误', '金额格式错误', () => {
      })
    } else if (this.form.tag == -1) {
      showDialog('表单验证错误', '请选择标签', () => {
      })
    } else {
      showDialog('添加记录', '确认提交数据', () => {
        const newForm: bookItem = {
          timeMap: getNowTime(),
          type: this.form.type,
          tag: this.form.tag,
          sum: this.form.sum,
          description: this.form.description
        };
        this.todayData.push(newForm)
        appendFile(getNowDate(), newForm)
        this.form.sum = ''
        this.form.description = ''
        this.form.tag = 0
        this.buttonText = '请选择标签'
        this.form.type = ''
        promptAction.showToast({
          message: '提交成功',
          bottom: 300
        })
      })
    }
  }

  build() {
    Column({ space: 25 }) {
      Row({ space: 10 }) {
        Text('类型').width('12%').titleStyle()
        Column() {
          Radio({ value: '支出', group: 'typeGroup' }).checked(this.form.type === '支出').onChange(() => {
            this.form.type = '支出'
          })
          Text('支出')
        }

        Column() {
          Radio({ value: '收入', group: 'typeGroup' }).checked(this.form.type === '收入').onChange(() => {
            this.form.type = '收入'
          })
          Text('收入')
        }
      }.justifyContent(FlexAlign.Start)

      Row({ space: 10 }) {
        Text('金额').width('12%').titleStyle()
        TextInput({ placeholder: '数目', text: this.form.sum }).onChange((val: string) => {
          this.form.sum = val
        }).width('80%')
      }.justifyContent(FlexAlign.Start)

      Row({ space: 10 }) {
        Text('标签').width('12%').titleStyle()
        tagMenu()
      }.justifyContent(FlexAlign.Start)

      Row({ space: 10 }) {
        Text('描述').width('12%').titleStyle()
        TextInput({ placeholder: '描述', text: this.form.description }).onChange((val: string) => {
          this.form.description = val
        }).width('80%')
      }.justifyContent(FlexAlign.Start).margin({ bottom: 30 })

      Flex({ direction: FlexDirection.RowReverse }) {
        Button("提交")
          .height(40)
          .width('30%')
          .padding(10)
          .onClick(() => {
            this.onSubmit()
          })
          .margin({ right: 30 })
      }
    }.alignItems(HorizontalAlign.Start).margin({ left: 20, right: 20 })

  }
}