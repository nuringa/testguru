document.addEventListener('turbolinks:load', function() {
  const currentProgress = document.querySelector('.progress-bar')

  if (currentProgress) {
    const width = currentProgress.dataset.width
    moveProgressBar(width)
  }

  function moveProgressBar(width) {
    const progress = document.querySelector('.progress-bar')
    progress.style.width = width + '%'
  }
})
