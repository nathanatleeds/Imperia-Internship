import React, { PureComponent } from "react";
import Person from "./Person/Person";

class Persons extends PureComponent {
  constructor(props) {
    super(props);
    console.log("[Persons.js] Inside Constructor", props);
  }

  componentWillMount() {
    console.log("[Persons.js] Inside componentWillMount()");
  }

  componentDidMount() {
    console.log("[Persons.js] Inside componentDidMount()");
  }

  componentWillReceiveProps(nextProps) {
    // called when the info is updated
  }

  //   shouldComponentUpdate(nextProps, nextState) {
  //     // true = updating continues
  //     // // false = stops
  //     // return nextProps.persons !== this.props.persons || nextProps.changed;
  //     // //return true;
  //   }

  componentWillUpdate(nextProps, nextState) {
    // if should = true
  }

  componentDidUpdate() {
    // after update. next props and state are now current
  }

  render() {
    console.log("[Persons.js] Inside render()");
    return this.props.persons.map((person, index) => {
      return (
        <Person
          click={() => this.props.clicked(index)}
          name={person.name}
          age={person.age}
          key={person.id}
          changed={event => this.props.changed(event, person.id)}
        />
      );
    });
  }
}

export default Persons;
