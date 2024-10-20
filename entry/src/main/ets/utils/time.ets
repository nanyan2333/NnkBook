export function getNowDate():string {
  const now = new Date()
  const year = now.getFullYear()
  const month = ("0" + (now.getMonth() + 1)).slice(-2)
  const day = ("0" + now.getDate()).slice(-2)
  const formattedTime = year + "-" + month + "-" + day
  return formattedTime
}
export function getNowTime():string{
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，因此要加1
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

}
export function getLastMonthDates():string[]{
  let dates:string[] = [];
  const now = new Date();

  for (let i = 0; i < 30; i++) { // 生成 30 天的日期
    const date = new Date(now);
    date.setDate(now.getDate() - i);
    const formattedDate:string = date.toISOString().split('T')[0]; // 格式化日期为 YYYY-MM-DD
    dates.push(formattedDate);
  }
  console.info(JSON.stringify(dates))
  return dates.reverse(); // 使日期从早到晚排序
}

