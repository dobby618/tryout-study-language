document.addEventListener('turbolinks:load', () => {
  // セレクトボックスの言語を変更してリダイレクトさせる
  const selectElement = document.querySelector('#schedules #language');
  if(selectElement) {
    selectElement.addEventListener('change', (event) => {
      const language = event.target.value
      const schedulesUrl = document.querySelector('#schedules').getAttribute("data-schedules-url")

      location.href = `${schedulesUrl}/?language=${language}`
    });
  }
})
