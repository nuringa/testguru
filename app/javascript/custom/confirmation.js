document.addEventListener('turbolinks:load', function() {
  const control1 = document.getElementById('password-control')
  const control2 = document.getElementById('confirmation-control')

  if (control1 && control2) {
    control1.addEventListener('input', showIcons)
    control2.addEventListener('input', showIcons)
  }
})

function showIcons() {
  const password = document.getElementById('password-control')
  const passwordConfirmation = document.getElementById('confirmation-control')

  if (password.value === '' || passwordConfirmation.value === '') {
    document.querySelector('.octicon-check').classList.add('hide')
    document.querySelector('.octicon-circle-slash').classList.add('hide')
    passwordConfirmation.classList.remove('focus-success', 'focus-warning')
  } else if (password.value === passwordConfirmation.value) {
      document.querySelector('.octicon-check').classList.remove('hide')
      document.querySelector('.octicon-circle-slash').classList.add('hide')
      passwordConfirmation.classList.add('focus-success')
  } else {
    document.querySelector('.octicon-check').classList.add('hide')
    document.querySelector('.octicon-circle-slash').classList.remove('hide')
    passwordConfirmation.classList.remove('focus-success')
    passwordConfirmation.classList.add('focus-warning')
  }
}
