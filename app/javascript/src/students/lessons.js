document.addEventListener('turbolinks:load', () => {
  // セレクトボックスで言語・日付を変更してリダイレクトする
  const selectStartDate = document.querySelector('#lessons select#start_date');
  if(selectStartDate) selectStartDate.addEventListener('change', () => toLessonPage());

  const selectLanguage = document.querySelector('#lessons select#language');
  if(selectLanguage) selectLanguage.addEventListener('change', () => toLessonPage());

  function toLessonPage() {
    const startDate = document.querySelector('#lessons select#start_date').value
    const language  = document.querySelector('#lessons select#language').value
    const lessonsUrl = document.querySelector('#lessons').getAttribute("data-lessons-url")

    location.href = `${lessonsUrl}/?start_date=${startDate}&language=${language}`
  }
})
