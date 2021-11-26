function action_button () {
  console.log(456456)

  const fab = document.querySelector('.fab');

  fab.addEventListener('click', () => {
    fab.classList.toggle('active');
  })
}

export {action_button}
