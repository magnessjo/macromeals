
// Set Window to location

export default function (element) {

  const elm = document.body;
  let from = document.documentElement.scrollTop || document.body.scrollTop;
  const to = element.getBoundingClientRect();
  const toPosition = to.top - from;
  const currentPosition = window.pageYOffset;
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
