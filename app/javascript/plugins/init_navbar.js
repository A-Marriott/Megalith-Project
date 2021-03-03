const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-megalithic');
  let scroll = window.pageYOffset || document.body.scrollTop;
  if (navbar) {
    window.addEventListener('scroll', () => {
      const currentScroll = window.pageYOffset || document.body.scrollTop;
      if (currentScroll > scroll) {
        navbar.classList.add('navbar-megalithic-transparent');
      } else {
        navbar.classList.remove('navbar-megalithic-transparent');
      }
      scroll = currentScroll <= 0 ? 0 : currentScroll;
    }, false);
  }
}
export { initUpdateNavbarOnScroll };
