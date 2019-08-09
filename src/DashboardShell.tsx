import React, { Component } from "react";
import { render } from "react-dom";

import { Sidebar } from './Sidebar';
import { View } from './View';

export class DashboardShell extends Component
{
	constructor(props:any = null)
	{
		super(props);
		render(<DashboardShell />, document.body);
	}

	render()
	{
		return(
			<main className="t-dashboard">
				<Sidebar></Sidebar>
				<View></View>
			</main>
		);
	}
}
