
const scrollAnimationClass = 'scroll-animation';
let values = [];

// Set position value

function setPositionValue(elements) {

  elements.forEach( (elm) => {

    const obj = {};
    const position = elm.getBoundingClientRect();
    obj.position = position.top;
    obj.elm = elm;
    values.push(obj);

  });

}

// Export

export default function(elements) {

  setPositionValue(elements);

  window.addEventListener('scroll', () => {

    const windowPosition = window.pageYOffset || document.documentElement.scrollTop;
    const windowHeight = window.innerHeight;

    if (elements.length == 0) return;

    values.forEach( (item) => {

      if (windowPosition + (windowHeight / 2) > item.position) {

        const element = item.elm;
        const parent = element.parentNode;
        const index = elements.indexOf(element);
        elements.splice(index, 1);
        parent.classList.add(scrollAnimationClass);

      }

    });

  });

  window.addEventListener('resize', () => { setPositionValue(elements) });

}
