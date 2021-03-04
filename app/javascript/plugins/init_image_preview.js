const previewImageOnFileSelect = () => {
  const input = document.getElementById('photo-input');
  if (input) {
    input.addEventListener('change', () => {
      displayPreview(input);
    })
  }
}

const displayPreview = (input) => {
  let count = 0;
  if (input.files && input.files[0]) {
    for (const [key, value] of Object.entries(input.files)) {
      document.getElementById('photo_upload_form').insertAdjacentHTML('afterend', `<img src="" class="hidden" width="200" id="photo-preview-${count}">`);

      const reader = new FileReader();

      reader.onload = (event) => {
        document.getElementById(`photo-preview-${count}`).src = event.currentTarget.result;
      }
      reader.readAsDataURL(value)
      document.getElementById(`photo-preview-${count}`).classList.remove('hidden');

      count += 1;
    }
  }
}

export { previewImageOnFileSelect };
