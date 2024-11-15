import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["brand", "gear"]

  connect() {
    console.log("BrandController connected");
  }

  // Function to fetch gears based on the selected brand
  loadGears() {
    const brandId = this.brandTarget.value;

    if (brandId === "") {
      this.gearTarget.innerHTML = "<option value=''>Select Gear</option>";
      return;
    }

    fetch(`/gears_for_brand/${brandId}`)
        .then(response => response.json())
        .then(data => {
          this.gearTarget.innerHTML = "";

          data.gears.forEach(gear => {
            const option = document.createElement('option');
            option.value = gear.id;
            option.textContent = gear.name;
            this.gearTarget.appendChild(option);
          });
        });
  }
};
