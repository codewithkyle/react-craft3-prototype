import React, { Component } from "react";
import { Route, NavLink, BrowserRouter as Router } from "react-router-dom";

import './sidebar.scss';

import { SignoutButton } from './SignoutButton';

/** View Components */
import { Dashboard } from './Dashboard';
import { Courses } from './Courses';

export class Sidebar extends Component
{
	componentWillMount()
	{
		window.history.replaceState({}, document.title, '/dashboard');
	}

	private navLinkClicked:EventListener = this.handleNavigation;

	private handleNavigation(e:Event)
	{
		const target = e.currentTarget as HTMLElement;
		
		if (!target || !target.dataset.link)
		{
			return;
		}
		
		switch(target.dataset.link)
		{
			case 'dashboard':
				new Dashboard();
				break;
			case 'courses':
				new Courses();
				break;
			case 'wishlist':
				console.warn('Wishlist not yet implemented');
				break;
			case 'teach':
				console.warn('Teach not yet implemented');
				break;
			case 'settings':
				console.warn('Settings not yet implemented');
				break;
			default:
				console.error('Unknown navigation type', e.type);
				break;
		}
	}

	componentDidMount()
	{
		const navigationLinks:Array<HTMLAnchorElement>|null = Array.from(document.body.querySelectorAll('aside nav a'));

		if (navigationLinks)
		{
			for (let i = 0; i < navigationLinks.length; i++)
			{
				navigationLinks[i].addEventListener('click', this.navLinkClicked);
			}
		}
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
						<NavLink data-link="dashboard" to="/dashboard" activeClassName="is-active">Dashboard</NavLink>
						<NavLink data-link="courses" to="/courses" activeClassName="is-active">Courses</NavLink>
						<NavLink data-link="wishlist" to="/wishlist" activeClassName="is-active">Wishlist</NavLink>
						<NavLink data-link="teach" to="/teach" activeClassName="is-active">Teach</NavLink>
						<NavLink data-link="settings" to="/settings" activeClassName="is-active">Settings</NavLink>
					</nav>
				</Router>
				<SignoutButton></SignoutButton>
			</aside>
		);
	}
}
