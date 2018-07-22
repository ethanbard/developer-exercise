import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import QuoteTable from './components/QuoteTable.js';

class App extends Component {
  
  constructor(props) {
    super(props);

    this.state = {
      quotes: [],
    };
  }

  componentDidMount() {
    fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/b191cf3b6ea9cdcca8b363516ff969261398061f/quotes.json')
      .then(response => response.json())
      .then(data => this.setState({quotes: data}));
  }

  render() {

    return (
      <div className="App">
        <p className="App-intro">
          The top movie and video game quotes of all time.
        </p>
        <QuoteTable quotes={this.state.quotes}></QuoteTable>
      </div>
    );
  }
}

export default App;
