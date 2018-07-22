import React, { Component } from 'react';
//import './App.css';

class QuoteTable extends Component {

    constructor() {
        super();
        this.state = {
            currentPage: 0
        };
        this.handlePageChange = this.handlePageChange.bind(this);
    }

    handlePageChange(event) {
        this.setState({currentPage: Number(event.target.id)});
    }

    render() {
        const quotes = this.props.quotes;
        
        let tableRows = quotes.map((quote, index) =>
            <tr key={index}>
                <td>{quote.quote}</td> 
                <td>{quote.source}</td>
                <td>{quote.context}</td>
                <td>{quote.theme}</td>
            </tr>
        );

        //***Provide pagination for the table***

        //First, calculate how many pages we need
        let pages = [];

        for (let i = 0; i < Math.ceil(tableRows.length / 15); i++) {
            pages.push(i);
        }
        
        //Then, create buttons for each page
        let pageButtons = pages.map(index =>
            <button key={index} id={index} onClick={this.handlePageChange}>{index + 1}</button>
        );

        //Slice the tableRows array to simulate separate pages
        var firstQuote = this.state.currentPage * 15; //Display 15 results per page
        var lastQuote = firstQuote + 15;

        return (
            <div>
            <table>
                <tr>
                <th>Quote</th>
                <th>Source</th>
                <th>Context</th>
                <th>Theme</th>
                </tr>
                {tableRows.slice(firstQuote, lastQuote)}
            </table>
            {pageButtons}
            </div>
        );
    }
}
export default QuoteTable;