
// Transverse DOM for Parent Node

export default function(element, parentClass) {

  while (element.parentNode) {

    element = element.parentNode;
    if (element == document.body) return;

    if (element.classList.contains(parentClass)) {
      return element;
    }

  }

}
