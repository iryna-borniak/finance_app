import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['category'];  

  filterCategories(event) {    
    const { value: searchTerm } = event.target;
    const searchTermLowercase = searchTerm.toLowerCase().trim();

    this.categoryTargets.forEach((category) => {
      const categoryTitle = category
        .querySelector('[data-title]')
        .innerText.toLowerCase();

      category.style.display = categoryTitle.includes(searchTermLowercase) ? '' : 'none';
    });
  }
}
