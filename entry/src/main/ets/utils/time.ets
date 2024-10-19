export function getCurrentDate():string{
  const nowDate = new Date()
  return `${nowDate.getFullYear()}-${nowDate.getMonth()+1}-${nowDate.getDate()}`
}