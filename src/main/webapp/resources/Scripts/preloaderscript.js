const loadercontainer = document.querySelector('.loadercontainer');

document.addEventListener('DOMContentLoaded', (e) => {
    setTimeout(() => {
        loadercontainer.classList.add('display-none');
    }, 1000);
})