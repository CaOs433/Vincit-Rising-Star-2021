import React from 'react';
import "bootstrap/dist/css/bootstrap.min.css";

// Bootstrap components
import { Container, Row, Col, Navbar } from 'react-bootstrap';

// Input View for date range
import InputView from './components/Input';
// Output View for the data
import OutputView from './components/Output';

/**
 *
 * @returns Main view of the app
 */
export default function App() {
  // Start date
  const [startDate, setStartDate] = React.useState<number>(-1);
  // End date
  const [endDate, setEndDate] = React.useState<number>(-1);

  // Is the input ok
  const [inputOk, setInputOk] = React.useState<boolean>(false);

  return (
    <div style={styles.body}>
      <main role="main" className="container-fluid" style={styles.main}>
        <Container fluid className="text-center">
          <Row>
            <Col sm={1} />
            {/* Content */}
            <Col sm={10} style={{ minWidth: "fit-content" }} >
              {/* Navbar (just title, brand ans App Store link) */}
              <Navbar className="navbar-inverse" bg="dark" variant="dark" expand="lg" style={styles.header}>
                <Container fluid>
                  <Navbar.Brand>
                    <img src="/bitcoin_icon.png" alt="bitcoin_icon" className="d-inline-block align-top" style={styles.brand_icon} />
                    <h1 className="d-inline-block align-top">Crypto Time Machine</h1>
                  </Navbar.Brand>
                  <a href="https://apps.apple.com/en/app/crypto-time-machine/id1602419673" rel="noreferrer" target="_blank" className="pull-right">
                    <img alt="app_store" src="Download_on_the_App_Store_Badge_US-UK_RGB_wht_092917.svg" />
                  </a>
                </Container>
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
                <Container fluid className="text-center">
                  <Row className="content-heading clearfix media">
                    <span>
                      {/*<a href="https://apps.apple.com/en/app/crypto-time-machine/id1602419673" rel="noreferrer" target="_blank" className="pull-left" style={{float: "left"}}>
                        <img alt="app_store" src="Download_on_the_App_Store_Badge_US-UK_RGB_wht_092917.svg" style={styles.app_store_badge} />
                      </a>*/}
                      <small><a href="https://github.com/CaOs433/Vincit-Rising-Star-2021" rel="noreferrer" target="_blank">Github</a> - Oskari Saarinen &copy; 2021</small>
                    </span>
                  </Row>
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

/**
 * CSS styles for App
 */
const styles: { [key: string]: React.CSSProperties } = {
  body: {
    marginLeft: 0,
    marginRight: 0,
    width: "100%",
    height: "100%",
    paddingTop: 20,
    //minWidth: 720
  },
  main: {
    marginLeft: "0px",
    marginBottom: "40px",
    marginTop: "0px"
  },
  header: {
    borderTopLeftRadius: "40px",
    borderTopRightRadius: "40px",
    borderBottomLeftRadius: "0px",
    borderBottomRightRadius: "0px"
  },
  container: {
    backgroundColor: "#A12",
    textAlign: "center"
  },
  footer: {
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
  },
  app_store_badge: {
    paddingRight: 10
  }
};
