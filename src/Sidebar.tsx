import React, { Component } from "react";
import { Route, Link, BrowserRouter as Router } from "react-router-dom";

import './sidebar.scss';

import { SignoutButton } from './SignoutButton';
import { Dashboard } from './Dashboard';

export class Sidebar extends Component
{
	render()
	{
		return(
			<aside>
				<div className="user-info">
					<div className="user-info_icon">
						<span>KA</span>
					</div>
					<span className="user-info_name">Kyle Andrews</span>
					<span className="user-info_email">kylea@page.works</span>
				</div>
				<Router>
					<nav>
						<Link to="/dashboard" className="is-active">Dashboard</Link>
						<Link to="/courses">Courses</Link>
						<Link to="/wishlist">Wishlist</Link>
						<Link to="/teach">Teach</Link>
						<Link to="/settings">Settings</Link>
					</nav>

					<Route path="/dashboard" component={Dashboard} />
					<Route path="/courses" component={Dashboard} />
					<Route path="/wishlist" component={Dashboard} />
					<Route path="/teach" component={Dashboard} />
					<Route path="/settings" component={Dashboard} />
				</Router>
				<SignoutButton></SignoutButton>
			</aside>
		);
	}
}
