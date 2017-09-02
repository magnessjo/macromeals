
// Variables

const wrapper = document.querySelector('.page-scroll-wrapper');
const documentBody = document.documentElement.scrollTop || document.body.scrollTop;
let nav;
let positionTop;

// Sroll Function

function scrollTo(position) {

  let from = 0;
  const elm = document.body;
  const currentPosition = window.pageYOffset;
  const to = document.querySelector(`section[data-location="${position}"]`).getBoundingClientRect();
  const toPosition = documentBody == 0 ? ((to.top - from) - 30) : ((to.top) - 30);
  let frames = 60;
  const jump = (toPosition - from) / frames;
  from = currentPosition;

  function scroll() {

    if (frames > 0) {

      const position = from + jump;

      from = position;
      elm.scrollTop = from;
      document.documentElement.scrollTop = from;

      frames--;
      window.requestAnimationFrame(scroll);

    }

  }

  window.requestAnimationFrame(scroll);

}

function windowSroll() {

  if (window.innerWidth > 768) {

    if (positionTop.top + documentBody < window.pageYOffset) {
      nav.style.position = 'fixed';
    } else {
      nav.style.position = 'relative';
    }

  }

}

// Export Function

export default function() {

  if (wrapper) {

    // Init

    const buttons = Array.from(wrapper.querySelectorAll('button'));
    nav = wrapper.querySelector('.page-nav');
    positionTop = wrapper.getBoundingClientRect();

    // Click Event

    buttons.forEach((button) => {

      button.addEventListener('click', e => {

        const positionAttr = button.getAttribute('data-id');
        scrollTo(positionAttr);

      });

    });

    // Scroll Event

    window.addEventListener('scroll', windowSroll);

    // Load

    windowSroll();

  }

}
