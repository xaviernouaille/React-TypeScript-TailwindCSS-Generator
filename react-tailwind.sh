#!/bin/bash
npx create-react-app $1 --template typescript
wait
cd ./$1
npm install -D tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9 @craco/craco
wait
node -p '
  const p = require("./package.json");
  p.scripts = {
    "start": "craco start",
     "build": "craco build",
     "test": "craco test",
     "eject": "react-scripts eject"
  };
  JSON.stringify(p, null, 2);
' > package.json.tmp &&
mv package.json.tmp package.json
wait
echo "module.exports = {
  style: {
    postcss: {
      plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
      ],
    },
  },
}
" >> craco.config.js
wait
npx tailwindcss-cli@latest init
wait
echo "@tailwind base;
@tailwind components;
@tailwind utilities;
" > ./src/index.css
wait
echo 'import "./App.css";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <div className="flex items-center space-x-20 mb-10">
          <img src="https://nextsoftware.io/files/images/logos/main/reactjs-logo.png" style={{width: "400px"}} alt="logo" />
          <p className="font-bold text-9xl font-mono">X</p>
          <img src="https://tailwindcss.com/_next/static/media/tailwindcss-mark.cb8046c163f77190406dfbf4dec89848.svg" style={{width: "400px"}} alt="logo-tailwind" />
        </div>
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;' > ./src/App.tsx
wait
echo -e "\e[1;32mYour React project with TypeScript & Tailwind CSS has been successfully created\e[0m"
npm start
