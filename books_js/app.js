let bookID = 0; 
let myLibrary = [];

function storageAvailable(type) {
    var storage;
    try {
        storage = window[type];
        var x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // everything except Firefox
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // test name field too, because code might not be present
            // everything except Firefox
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // acknowledge QuotaExceededError only if there's something already stored
            (storage && storage.length !== 0);
    }
}

function Book(id, title, author, pages, read){
    this.id = id;
    this.title = title;
    this.author = author;
    this.pages = pages;
    this.read = read;
}

Book.prototype.printInfo = function (){
    const readString = (this.read ? "read" : "unread");
    const infoString = "by " + this.author + ", " + this.pages + " pages, " + readString;
        return infoString;
}

const container = document.querySelector('#container');
function updateDisplay(){
    while (container.firstChild){
        container.firstChild.remove();
    }
    if (myLibrary == null || myLibrary == undefined){
        return;
    } else {
        let card;
        let header;
        let para;
        let remove;
        let read;

        myLibrary.forEach((book) => {
            if (book == null || book == undefined){
                return;
            } else {
                card = document.createElement('div');
                card.className = "card " + book.id;
                container.appendChild(card);

                header = document.createElement('h3');
                header.textContent = book.title;
                card.appendChild(header);

                para = document.createElement('p');
                para.textContent = book.printInfo();
                card.appendChild(para);

                read = document.createElement('button');
                read.className= "read";
                read.textContent = (book.read ? "Mark as un-read" : "Mark as read");
                read.addEventListener("click", function() {
                    book.read = (book.read ? false : true);
                    updateDisplay();
                });
                card.appendChild(read);

                remove = document.createElement('button');
                remove.className = "remove";
                remove.setAttribute("id", book.id);
                remove.textContent = "Remove book";
                remove.addEventListener("click", function (event) {
                    removeBookFromLibrary(event.target.id);
                });
                card.appendChild(remove);

                            }
        });

        const breakline = document.createElement('br');

        card = document.createElement('div');
        card.className = "card form";
        container.appendChild(card);
        const form = document.createElement('form');
        form.setAttribute("id", "form");
        card.appendChild(form);

        const labeltitle = document.createElement('label');
        labeltitle.setAttribute("for", "title");
        labeltitle.textContent = "Title:";
        const inputtitle = document.createElement('input');
        inputtitle.setAttribute("type", "text");
        inputtitle.setAttribute("name", "title");
        inputtitle.setAttribute("id", "title");
        labeltitle.appendChild(breakline);
        inputtitle.appendChild(breakline);
        form.appendChild(labeltitle);
        form.appendChild(inputtitle);

        const labelAuthor = document.createElement('label');
        labelAuthor.setAttribute("for", "author");
        labelAuthor.textContent = "Author:";
        const inputAuthor = document.createElement('input');
        inputAuthor.setAttribute("type", "text");
        inputAuthor.setAttribute("name", "author");
        inputAuthor.setAttribute("id", "author");
        labelAuthor.appendChild(breakline);
        inputAuthor.appendChild(breakline);
        form.appendChild(labelAuthor);
        form.appendChild(inputAuthor);

        const labelPages = document.createElement('label');
        labelPages.setAttribute("for", "pages");
        labelPages.textContent = "Number of Pages:";
        const inputPages = document.createElement('input');
        inputPages.setAttribute("type", "text");
        inputPages.setAttribute("name", "pages");
        inputPages.setAttribute("id", "pages");
        labelPages.appendChild(breakline);
        inputPages.appendChild(breakline);
        form.appendChild(labelPages);
        form.appendChild(inputPages);
        
        const labelRead = document.createElement('label');
        labelRead.setAttribute("for", "read");
        labelRead.textContent = "Finished?";
        const inputRead = document.createElement('input');
        inputRead.setAttribute("type", "checkbox");
        inputRead.setAttribute("name", "read");
        inputRead.setAttribute("id", "read");
        inputRead.appendChild(breakline);
        form.appendChild(labelRead);
        form.appendChild(inputRead);
    
        const addButton = document.createElement('button');
        addButton.className = "add";
        addButton.textContent = "Add Book";
        form.appendChild(addButton);

        const clearButton = document.createElement('button');
        clearButton.className = "clear";
        clearButton.textContent = "Clear Library";
        form.appendChild(clearButton);
    }
}

updateDisplay();

function addBookToLibrary(book){
    myLibrary.push(book);
    updateDisplay();

     if (storageAvailable('localStorage')) {
        localStorage.setItem("library", JSON.stringify(myLibrary));
        localStorage.setItem("ids", JSON.stringify(bookID));
        console.log("library saved locally");
    } else {
        // Too bad, no localStorage for us
    }
}

function removeBookFromLibrary(index){
    myLibrary[index] = undefined;
    delete myLibrary[index];
    updateDisplay();
}

if (!localStorage.getItem('library')){
    // if no local storage use defaults
    const book1 = new Book(bookID++, "How To Write One Song", "Jeff Tweedy", 151, false);
    const book2 = new Book(bookID++, "Tao Te Ching", "Lao Tzu", 224, true);
    addBookToLibrary(book1);
    addBookToLibrary(book2);
} else {
    // load the library
    const b = JSON.parse(localStorage.getItem('library'));
    bookID = JSON.parse(localStorage.getItem('ids'));

    let tempBook;
    for (let i = 0; i < b.length; i++){
        if (b[i] == null || b[i] == undefined){
            // do nothing
        } else {
            tempBook = new Book(b[i].id, b[i].title, b[i].author, b[i].pages, b[i].read);
            addBookToLibrary(tempBook);
        }
    }

    updateDisplay();
}

const button = document.querySelector('.add');
button.onclick = function() {
    const id = bookID++;
    const title = document.getElementById('title').value;
    const author = document.getElementById('author').value;
    const pages = Number(document.getElementById('pages').value);
    const read = Boolean(document.getElementById('read').value);

    if (title == null || title == "",  
        author == null || author == "", 
        pages == null || pages == "")
    {
        return;
    }
    else 
    {
        const book = new Book(id, title, author, pages, read);
        addBookToLibrary(book);
    }
}

const clear = document.querySelector('.clear');
clear.onclick = function() {
    localStorage.clear();
    location.reload();
}
