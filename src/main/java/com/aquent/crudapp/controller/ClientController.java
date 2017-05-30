package com.aquent.crudapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.aquent.crudapp.domain.Client;
import com.aquent.crudapp.service.ClientService;
import com.aquent.crudapp.service.PersonService;
import java.util.Arrays;
import java.util.Map;
import org.springframework.web.bind.annotation.ModelAttribute;

/**
 * Controller for handling basic client management operations.
 */
@Controller
@RequestMapping("client")
public class ClientController {

    public static final String COMMAND_DELETE = "Delete";

    @Inject private ClientService clientService;
    @Inject private PersonService personService;  // to get person list for specific clients.

    /**
     * Renders the listing page.
     *
     * @return list view populated with the current list of people
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("client/list");
        mav.addObject("clients", clientService.listClients());
        return mav;
    }

    /**
     * Renders an empty form used to create a new client record.
     *
     * @return create view populated with an empty client
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public ModelAndView create() {
        ModelAndView mav = new ModelAndView("client/create");
        mav.addObject("client", new Client());
        mav.addObject("errors", new ArrayList<String>());
        return mav;
    }

    /**
     * Validates and saves a new client.
     * On success, the user is redirected to the listing page.
     * On failure, the form is redisplayed with the validation errors.
     *
     * @param client populated form bean for the client
     * @return redirect, or create view with errors
     */
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public ModelAndView create(Client client) {
        List<String> errors = clientService.validateClient(client);
        if (errors.isEmpty()) {
            clientService.createClient(client);
            return new ModelAndView("redirect:/client/list");
        } else {
            ModelAndView mav = new ModelAndView("client/create");
            mav.addObject("client", client);
            mav.addObject("errors", errors);
            return mav;
        }
    }

    /**
     * Renders an edit form for an existing client record.
     *
     * @param clientId the ID of the client to edit
     * @return edit view populated from the client record
     */
    @RequestMapping(value = "edit/{clientId}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable Integer clientId) {
        ModelAndView mav = new ModelAndView("client/edit");
        mav.addObject("client", clientService.readClient(clientId));
        mav.addObject("errors", new ArrayList<String>());
		
		// for the detail view of all persons belonging to this client.
		mav.addObject("personListForClient", personService.listPeopleForClient(clientId));
		
        return mav;
    }

    /**
     * Validates and saves an edited client.
     * On success, the user is redirected to the listing page.
     * On failure, the form is redisplayed with the validation errors.
     *
     * @param client populated form bean for the client
     * @return redirect, or edit view with errors
     */
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ModelAndView edit(Client client) {
        List<String> errors = clientService.validateClient(client);
        if (errors.isEmpty()) {
            clientService.updateClient(client);
            return new ModelAndView("redirect:/client/list");
        } else {
            ModelAndView mav = new ModelAndView("client/edit");
            mav.addObject("client", client);
            mav.addObject("errors", errors);
            return mav;
        }
    }

    /**
     * Renders the deletion confirmation page.
     *
     * @param clientId the ID of the client to be deleted
     * @return delete view populated from the client record
     */
    @RequestMapping(value = "delete/{clientId}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable Integer clientId) {
        ModelAndView mav = new ModelAndView("client/delete");
        mav.addObject("client", clientService.readClient(clientId));
        return mav;
    }

    /**
     * Handles client deletion or cancellation, redirecting to the listing page in either case.
     *
     * @param command the command field from the form
     * @param clientId the ID of the client to be deleted
     * @return redirect to the listing page
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public String delete(@RequestParam String command, @RequestParam Integer clientId) {
        if (COMMAND_DELETE.equals(command)) {
            clientService.deleteClient(clientId);
        }
        return "redirect:/client/list";
    }
	
    /**
     * Renders the deletion confirmation page.
     *
     * @param clientId the ID of the client to be deleted
     * @return delete view populated from the client record
     */
    @RequestMapping(value = "multiAssignPersons/{clientId}", method = RequestMethod.GET)
    public ModelAndView multiAssignPersons(@PathVariable Integer clientId) {
        ModelAndView mav = new ModelAndView("client/multiAssignPersons");
		
		// current client we are working with
        mav.addObject("client", clientService.readClient(clientId));
		// full list of people for the checkboxes.... (also used to dsplay names, etc)
		mav.addObject("personList", personService.listPeople());
		// to hold the selected checkboxes (personId's) when the form gets submitted
		mav.addObject("selectionList", new ArrayList<Integer>());	
		
		// anybody in the curClientPersonList that is not in the selectionList will have to be
		// set to -1 (None).  anybody in the selectionList not in the curClientPersonList
		// will have to be set to this client. (on the POST submit)
        return mav;
    }

    /**
     * Handles client deletion or cancellation, redirecting to the listing page in either case.
     *
	 * @param clientId
	 * @param selPersons
     * @return redirect to the listing page
     */
    @RequestMapping(value = "multiAssignPersons", method = RequestMethod.POST)
    public String multiAssignPersons(@RequestParam Integer clientId, @RequestParam String[] selPersons) {
		List<Integer> selectionList = new ArrayList<>();
		// if none of the checkboxes were checked, then the selPersons array will be null.
		for (int i = 0; i < selPersons.length; i++)
			{
			String selPerson = selPersons[i];
			// placeholder hack so we always get a selPersons request param even if no checkboxes were checked.
			if( selPerson.equalsIgnoreCase("ignore") == false)
				selectionList.add( Integer.parseInt(selPerson.trim(), 10));
			}
		personService.syncPeopleForClient(clientId, selectionList);  
		return "redirect:/client/edit/"+clientId;
    }
	
   @ModelAttribute("clientSelectList")
   public Map<String, String> getClientSelectList()
   {
//      Map<String, String> clientSelectList = new HashMap<String, String>();
      Map<String, String> clientSelectList = clientService.clientSelectItemsMap();
	  System.out.println("getClientSelectList(): " + clientSelectList);
      return clientSelectList;
   }
	
}
