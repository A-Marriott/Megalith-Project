const initUpdateNavbarOnScroll = () => {

    const navbar = document.querySelector('.navbar-megalithic');
    if (navbar) {
      window.addEventListener('scroll', () => {
        if (window.scrollY >= window.innerHeight) {
          navbar.classList.add('navbar-megalithic-transparent');
        } else {
          navbar.classList.remove('navbar-megalithic-transparent');
        }
      });
    }
}

export { initUpdateNavbarOnScroll };
