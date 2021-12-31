import React from 'react';
import "bootstrap/dist/css/bootstrap.min.css";

import { Container, Row, Col, Navbar } from 'react-bootstrap';

import InputView from './components/Input';
import OutputView from './components/Output';

export default function App() {
  const [startDate, setStartDate] = React.useState<number>(-1);
  const [endDate, setEndDate] = React.useState<number>(-1);

  const [inputOk, setInputOk] = React.useState<boolean>(false);

  return (
    <div style={styles.body}>
      <main role="main" className="container-fluid" style={styles.main}>
        <Container fluid className="text-center">
          <Row>
            <Col sm={1} />
            {/* Content */}
            <Col sm={10} style={{ minWidth: "fit-content" }} >
              {/* Navbar (just title and brand) */}
              <Navbar className="navbar-inverse" bg="dark" variant="dark" expand="lg" style={styles.header}>
                <Navbar.Brand>
                  <img src="/bitcoin_icon.png" alt="bitcoin_icon" className="d-inline-block align-top" style={styles.brand_icon} />
                  <h1 className="d-inline-block align-top">Crypto Time Machine</h1>
                </Navbar.Brand>
              </Navbar>
              {/* Main content */}
              <Container fluid style={styles.container}>
                <br />
                <InputView setStartDate={setStartDate} setEndDate={setEndDate} setOutputOk={setInputOk} />
                <hr />
                {inputOk ? <OutputView startDate={startDate} endDate={endDate} /> : <></>}
                <br />
              </Container>
              {/* Page footer */}
              <footer id="sticky-footer" className="site-footer clearfix py-2 bg-dark text-white-50 mr-auto" style={styles.footer} >
                <Container className="text-center">
                  <small><a href="https://github.com/CaOs433/Vincit-Rising-Star-2021" rel="noreferrer" target="_blank">Github</a> - Oskari Saarinen &copy; 2021</small>
                </Container>
              </footer>
            </Col>
            <Col sm={1} />
          </Row>
        </Container>
      </main>
    </div>
  );
}

const styles: { [key: string]: React.CSSProperties } = {
  body: {
    marginLeft: 0,
    marginRight: 0,
    width: "100%",
    height: "100%",
    paddingTop: 20,
    //backgroundColor: "#FF0000CC",//"#eee"//"#AA22CCAA"
    //backgroundImage: "url(/bg.svg)"
  },
  main: {
    marginLeft: "0px",
    marginBottom: "40px",
    marginTop: "0px",
    //backgroundColor: "#FF0000CC"
  },
  header: {
    //display: "flex", //"block"
    //position: "relative",
    borderTopLeftRadius: "40px",
    borderTopRightRadius: "40px",
    borderBottomLeftRadius: "0px",
    borderBottomRightRadius: "0px",
    //marginBottom: 0
  },
  container: {
    backgroundColor: "#A12",//"#1133DDBB",//"#2244CCBB",
    textAlign: "center",
    //marginTop: 0
  },
  footer: {
    //display: "flex",//"block",
    //position: "relative",
    borderTopLeftRadius: "0px",
    borderTopRightRadius: "0px",
    borderBottomLeftRadius: "30px",
    borderBottomRightRadius: "30px",
    marginTop: "-16px",
    backgroundColor: "rgba(200,200,200,0.2)"
  },
  brand_icon: {
    width: "54px",
    height: "54px",
    marginRight: "8px",
    marginLeft: "14px"
  }
};
