import React from "react";
import { render } from "react-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import Movie from "../components/Movie";

document.addEventListener("DOMContentLoaded", () => {
  render(
    <Movie />,
    document.body.appendChild(document.createElement("div"))
  );
});