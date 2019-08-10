import React, { Component } from "react";
import { render } from "react-dom";

export class Courses extends Component
{
	constructor(props:any = null)
	{
		super(props);
		const view = document.body.querySelector('main section');
		render(<Courses />, view);
	}
	
	render()
	{
		return(
			<div>Courses</div>
		);
	}
}
