
// Variables

const rows = Array.from(document.querySelectorAll('.size-row'));
const locationMap = {};
let windowTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
let windowHeight = window.innerHeight;

// Debounce

function debounce(func, wait, immediate) {
	var timeout;
	return function() {
		var context = this, args = arguments;
		var later = function() {
			timeout = null;
			if (!immediate) func.apply(context, args);
		};
		var callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(later, wait);
		if (callNow) func.apply(context, args);
	};
};

// Scroll

const scroll = debounce(() => {

  windowTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;

  for (const key in locationMap) {

    if (key < windowTop + (windowHeight / 2)) {

      if (!locationMap[key] .classList.contains('skip-animation')) {
        locationMap[key].classList.add('start-animation');
      }

    }

  }

}, 15);

// Resize

function resize() {

  windowHeight = window.innerHeight;

  calculateSize().then(() => {

    rows.forEach((row, i) => {
      const position = row.getBoundingClientRect();
      locationMap[position.top + windowTop] = row;
    });

  });

}

// Caculate Size

function calculateSize() {

  return new Promise((resolve) => {

    let maxSize = 0;

    rows.forEach((block, i) => {

      const size = block.offsetHeight;

      if (size > maxSize) {
        maxSize = size;
      }

      if (i == rows.length - 1) {
        setSize(maxSize);
        resolve();
      }

    });

  });

}

// Set Size

function setSize(size) {

  rows.forEach((block) => {
    block.style.height = `${size}px`;
  });

}


// Load

function load() {

  calculateSize();

  for (const key in locationMap) {

    if (key - windowHeight < windowTop ) {
      locationMap[key].classList.add('skip-animation');
    }

  }

}

// Export

export default function() {

  if (window.matchMedia('(min-width: 768px)').matches) {

    window.addEventListener('resize', resize);
    window.addEventListener('scroll', scroll);

    resize();
    load();

	}

}
