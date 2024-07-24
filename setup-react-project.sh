#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
  echo "Please provide a project name."
  echo "Usage: $0 <project-name>"
  exit 1
fi

PROJECT_NAME=$1

# Create React App
npx create-react-app $PROJECT_NAME

# Navigate into the project directory
cd $PROJECT_NAME || exit

# Create folder structure
mkdir -p src/assets/images
mkdir -p src/assets/styles
mkdir -p src/components/common
mkdir -p src/components/layout
mkdir -p src/components/specific
mkdir -p src/pages
mkdir -p src/services
mkdir -p src/utils

# Create basic files with initial content

# App.js
cat > src/App.js <<EOL
import React from 'react';
import './App.css';
import Header from './components/layout/Header';
import Footer from './components/layout/Footer';
import HomePage from './pages/HomePage';

function App() {
  return (
    <div className="App">
      <Header />
      <main>
        <HomePage />
      </main>
      <Footer />
    </div>
  );
}

export default App;
EOL

# Header.js
cat > src/components/layout/Header.js <<EOL
import React from 'react';

function Header() {
  return (
    <header>
      <h1>Garage Sale Finder</h1>
    </header>
  );
}

export default Header;
EOL

# Footer.js
cat > src/components/layout/Footer.js <<EOL
import React from 'react';

function Footer() {
  return (
    <footer>
      <p>&copy; 2024 Garage Sale Finder</p>
    </footer>
  );
}

export default Footer;
EOL

# HomePage.js
cat > src/pages/HomePage.js <<EOL
import React from 'react';

function HomePage() {
  return (
    <div>
      <h2>Welcome to the Garage Sale Finder</h2>
      <p>Find the best garage sales near you!</p>
    </div>
  );
}

export default HomePage;
EOL

# App.css
cat > src/App.css <<EOL
.App {
  text-align: center;
}

header {
  background-color: #282c34;
  padding: 20px;
  color: white;
}

footer {
  background-color: #282c34;
  padding: 10px;
  color: white;
  position: fixed;
  bottom: 0;
  width: 100%;
}
EOL

# index.css
cat > src/index.css <<EOL
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
EOL

echo "Project setup complete. Navigate to the $PROJECT_NAME directory and start your development server with 'npm start'."
