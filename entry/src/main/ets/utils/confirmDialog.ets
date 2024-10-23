export function showDialog(_title: string, _message: string, _callback_confirm: Function) {
  AlertDialog.show({
    title: _title,
    subtitle: '',
    message: _message,
    primaryButton: {
      value: '取消',
      action: ()=>{}
    },
    secondaryButton: {
      value: '确认',
      action: ()=>{_callback_confirm()}
    }
  })
}