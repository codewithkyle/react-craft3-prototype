import React, { Component } from "react";
import { Route, NavLink, BrowserRouter as Router } from "react-router-dom";

import './sidebar.scss';

import { SignoutButton } from './SignoutButton';
import { Dashboard } from './Dashboard';

export class Sidebar extends Component
{
	componentWillMount()
	{
		window.history.replaceState({}, document.title, '/dashboard');
	}
	
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
						<NavLink to="/dashboard" activeClassName="is-active">Dashboard</NavLink>
						<NavLink to="/courses" activeClassName="is-active">Courses</NavLink>
						<NavLink to="/wishlist" activeClassName="is-active">Wishlist</NavLink>
						<NavLink to="/teach" activeClassName="is-active">Teach</NavLink>
						<NavLink to="/settings" activeClassName="is-active">Settings</NavLink>
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
