document.addEventListener('turbolinks:load', () => {
  // セレクトボックスの言語を変更してリダイレクトさせる
  const selectElement = document.querySelector('#language');
  if(selectElement) {
    selectElement.addEventListener('change', (event) => {
      const selectedLanguage = event.target.value
      const updateUrl = event.target.getAttribute("data-update-url")

      location.href = `${updateUrl}/?language=${selectedLanguage}`
    });
  }
})
