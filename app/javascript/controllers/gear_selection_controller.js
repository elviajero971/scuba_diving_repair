import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["brand", "gear", "gearType"]

    connect() {
        console.log("Gear selection controller connected")

        const selectedGearType = this.gearTypeTarget.value
        if (selectedGearType) {
            console.log("Preselected gear type:", selectedGearType)
            this.updateBrands({ target: { value: selectedGearType } })
        }
    }

    updateBrands(event) {
        const gearType = event.target.value
        console.log("Selected Gear Type:", gearType)

        // Fetch brands based on the selected gear type
        fetch(`/brands/by_gear_type?gear_type=${gearType}`)
            .then(response => response.json())
            .then(data => {
                this.brandTarget.innerHTML = `<option value=''>${window.I18n.form.brand_label}</option>`
                data.forEach(brand => {
                    this.brandTarget.innerHTML += `<option value='${brand.id}'>${brand.name}</option>`
                })
            })
            .catch(error => console.log("Error fetching brands:", error))
    }

    updateGears(event) {
        const brandId = event.target.value
        console.log("Selected Brand ID:", brandId)

        const gearType = this.gearTypeTarget.value

        console.log("i18n:", window.I18n.form.select_gear)

        // Fetch gears based on the selected brand and gear type
        fetch(`/gears/by_brand_and_type?brand_id=${brandId}&gear_type=${gearType}`)
            .then(response => response.json())
            .then(data => {
                this.gearTarget.innerHTML = `<option value=''>${window.I18n.form.gear_label}</option>`
                data.forEach(gear => {
                    this.gearTarget.innerHTML += `<option value='${gear.id}'>${gear.name}</option>`
                })
            })
            .catch(error => console.log("Error fetching gears:", error))
    }
}
