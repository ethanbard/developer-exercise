import React, { Component } from 'react';

class QuoteFilter extends Component {
    
    render() {
        const currentTheme = this.props.currentTheme;
        
        //Disable the button for the current theme
        let allButton
        let moviesButton
        let gamesButton

        if (currentTheme === "all") {
            allButton = <button class="disabled" onClick={() => this.props.onThemeChange("all")} disabled>All</button>
        } else {
            allButton = <button onClick={() => this.props.onThemeChange("all")}>All</button>
        }

        if (currentTheme === "movies") {
            moviesButton = <button class="disabled" onClick={() => this.props.onThemeChange("movies")} disabled>Movies</button>
        } else {
            moviesButton = <button onClick={() => this.props.onThemeChange("movies")}>Movies</button>
        }

        if (currentTheme === "games") {
            gamesButton = <button class="disabled" onClick={() => this.props.onThemeChange("games")} disabled>Games</button>
        } else {
            gamesButton = <button onClick={() => this.props.onThemeChange("games")}>Games</button>
        }


        return (
            <div>
                Filter by keyword:
                <input type="text" id="search" />
                <button onClick={() => this.props.onFilter(document.getElementById("search").value)}>Search</button>
                <br />
                <br />
                Theme:
                {allButton}
                {moviesButton}
                {gamesButton}
            </div>
        );
    }
}

export default QuoteFilter;